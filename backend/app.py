
import uuid
import motor
import tornado.ioloop
import tornado.web
import tornado.gen
from tornado.options import define, options

import json
import bson

from redis import Redis

db = motor.MotorClient().pogether

define("port", default=8888, help="run on the given port", type=int)


redis = Redis()


class BaseHandler(tornado.web.RequestHandler):
    def get_current_session(self):
        token = json.loads(self.request.body.decode("utf8"))["token"]
        return {'user': redis.get(token)}
    def get_current_user(self):
        if getattr(self, 'session', None) is None:
            self.session = self.get_current_session()
        return json.loads(self.request.body.decode("utf8"))["token"]
    def check_logout_state(self):
        print('user' not in self.session)
        print(self.session['user'])
        return 'user' not in self.session or self.session['user'] is None



class LoginHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            data = json.loads(self.request.body.decode("utf8"))
            username, passwd = data["username"], data["password"]
            users = yield (db.users.find({"username": username}).to_list(None))
            if len(users) == 0 or users[0]["password"] != passwd:
                self.set_status(405)
                self.write({"error": "The account does not exist or wrong password."})
            else:
                self.session['user'] = users[0]['username']
                redis.set(self.get_secure_cookie("user"), self.session['user'])
                self.set_status(200)
                del users[0]['_id']
                del users[0]['password']
                self.write(json.dumps(users[0]))
        else:
            self.set_status(405)
            self.write({"error": "Please logout first."})



class LogoutHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write({"error": "You aren't logged in."})
        else:
            redis.delete(self.get_secure_cookie("user"))
            self.set_status(200)
            self.write({"msg": ""})



class SignUpHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            data = json.loads(self.request.body.decode("utf8"))
            email, username, passwd = data["email"], data["username"], data["password"]
            users_1 = db.users.find({"email": email})
            users_1 = yield (db.users.find({"email": email}).to_list(None))
            users_2 = yield (db.users.find({"username": username}).to_list(None))
            users = list(users_1) + list(users_2)
            if len(users) > 0:
                self.set_status(405)
                self.write(json.dumps({"msg": "Email or Username duplicates."}))
            else:
                yield db.users.insert({
                    "email": email, 
                    "username": username, 
                    "password": passwd,
                    "signature": "",
                    "avatar": "",
                    "background": ""
                })
                yield db.friends.insert({"username": username, "friend_list": []})
                self.set_status(200)
                self.write(json.dumps({"ok": "Sign up successfully."}))
        else:
            self.set_status(405)
            self.write(json.dumps({"error": "Please logout first."}))



class SearchUsersHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            data = json.loads(self.request.body.decode("utf8"))
            partial_username = data['keyword']
            if 'username' in data:
                username = data['username']
                friends = yield db.friends.find({"username": username}).to_list(None)
                friends = list(friends)
                ret_info = []
                for friend_name in friends[0]["friend_list"]:
                    if partial_username in friend_name:
                        user = yield db.users.find_one({"username": friend_name})
                        ret_info.append(user)
                        del ret_info[-1]["password"]
                        del ret_info[-1]["_id"]
                self.set_status(200)
                self.write(json.dumps(ret_info))
            else:
                users = yield db.users.find({"username": {"$regex": ".*%s.*" % partial_username}}).to_list(None)
                print(".*%s.*" % partial_username)
                for user in users:
                    del user['password']
                    del user["_id"]
                self.set_status(200)
                self.write(json.dumps(users))



class AddFriendHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        data = json.loads(self.request.body.decode("utf8"))
        friend_name = data["username"]
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            users = (yield(db.friends.find({"username": self.session["user"].decode("utf8")}).to_list(None)))
            print(users)
            yield db.friends.update({"username": self.session['user'].decode('utf8')}, {"$push": { "friend_list": friend_name } })
            self.set_status(200)



class DelFriendHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        data = json.loads(self.request.decode("utf8"))
        friend_name = data["username"]
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            yield db.friends.update({"username": self.session['user'].decode("utf8")}, {"$pull": {"friend_list": friend_name}})
            self.set_status(200)



class CreateAlbumHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            data = json.loads(self.request.body.decode("utf8"))
            albumname = data["albumname"]
            ids = yield db.album.find({"username": self.session['user'].decode("utf8"), "albumname": albumname}).to_list(None)
            if len(ids) > 0:
                self.set_status(405)
                self.write({"error": "Album's name duplicates"})
            else:
                self.set_status(200)
                yield db.album.insert({
                    "username": self.session['user'].decode("utf8"),
                    "albumname": albumname,
                    "count": 0,
                    })



class DeleteAlbumHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            data = json.loads(self.request.body.decode("utf8"))
            albumname = data["albumname"]
            ids = yield db.album.find({"username": self.session['user'].decode('utf8'), "albumname": albumname}).to_list(None)
            if len(ids) > 0:
                self.set_status(405)
                self.write({"error": "Album's name duplicates"})
            else:
                self.set_status(200)
                yield db.album.remove({
                    "username": self.session['user'].decode('utf8'),
                    "albumname": albumname,
                    "count": 0,
                    }, {'justOne': True})



class CreatePhotoHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            data = json.loads(self.request.body.decode("utf8"))
            albumname, url = data['albumname'], data['url']
            yield db.photos.insert({
                'username': self.session['user'].decode("utf8"),
                'albumname': albumname,
                'url': url
                })


class DelPhotoHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            data = json.loads(self.request.body.decode("utf8"))
            albumname, url = data["albumname"], data["url"]
            yield db.photos.remove({
                "albumname": albumname,
                "url": url,
                "username": self.session['user'].decode("utf8")
                }, {"justOne": True})


class ChangePersonalDetailsHandler(BaseHandler):
    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):
        self.get_current_user()
        if self.check_logout_state():
            self.set_status(405)
            self.write(json.dumps({"error": "Please login in first."}))
        else:
            data = json.loads(self.request.body.decode("utf8"))
            username = data['username']
            yield db.users.update(
                    {'username': username},
                    data)
            self.set_status(200)


application = tornado.web.Application([
    (r"/login", LoginHandler),
    (r"/signup", SignUpHandler),
    (r'/signout', LogoutHandler),
    (r"/searchuser", SearchUsersHandler),
    (r"/addfriend", AddFriendHandler),
    (r"/deletefriend", DelFriendHandler),
    (r"/album/create", CreateAlbumHandler),
    (r"/album/delete", DeleteAlbumHandler),
    (r"/album/addphoto", CreatePhotoHandler),
    (r"/album/deletephoto", DelPhotoHandler),
    (r"/changedetails", ChangePersonalDetailsHandler),
    ], cookie_secret="ljhegrqkjfkajsbxkjcghwuer")

if __name__ == "__main__":
    tornado.options.parse_command_line()
    application.listen(options.port, address="0.0.0.0")
    tornado.ioloop.IOLoop.instance().start()


