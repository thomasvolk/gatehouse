#!/usr/bin/env python3
from http.server import HTTPServer, SimpleHTTPRequestHandler
import re, sys, os
from http import cookies
from urllib.parse import urlparse
from urllib.parse import parse_qs
try:
    import jwt
    from jwt.exceptions import InvalidTokenError
except ImportError:
    print("ERROR: JWT library not found, install pyjwt")
    print("    pip3 install pyjwt")
    sys.exit(1)

AUDIENCE='Gatehouse'
ISSUER='Gatehouse'
GATEHOUSE_URL=os.environ.get('GATEHOUSE_URL', 'http://0.0.0.0:4000')
SECRET_KEY=os.environ.get('SECRET_KEY', "dev_A1yzSKfmfiQgwZ08vIeuXUQqkG8")
PORT=int(os.environ.get('PORT', 8000))

class Token(object):
    @staticmethod
    def decode(token):
        if token != None:
            try:
                decoded = jwt.decode(token, SECRET_KEY, issuer=ISSUER, audience=AUDIENCE, algorithms=['HS512'])
                return Token(token, decoded)
            except InvalidTokenError as e:
                print("InvalidTokenError: ", e)
        return None

    def __init__(self, token, decoded):
        self.token = token
        self.decoded = decoded

class TestRequestHandler(SimpleHTTPRequestHandler):

    def _get_token_from_cookie(self):
        cookieHeader = self.headers.get('Cookie')
        if cookieHeader != None:
            cookie = cookies.SimpleCookie()
            cookie.load(cookieHeader)
            try:
                return Token.decode(cookie["access_token"].value)
            except KeyError:
                pass

    def _get_token_from_url(self):
        params = parse_qs(urlparse(self.path).query)
        if 'access_token' in params:
            return Token.decode(params['access_token'][0])
        return None

    def _redirect_to_auth_server(self):
        (host, port) = self.server.server_address
        target = "http://%s:%s%s" % (host, port, self.path)
        self.send_response(302)
        self.send_header('Location', "%s?target=%s" % (GATEHOUSE_URL, target))
        self.end_headers()

    def _do_response(self, cookie = None):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        if cookie != None:
            self.send_header('Set-Cookie', cookie)
        self.end_headers()
        SimpleHTTPRequestHandler.do_GET(self)

    def do_GET(self):
        token = self._get_token_from_url()
        if token != None:
            self._do_response(cookie = 'access_token=%s' % token.token)
        else:
            token = self._get_token_from_cookie()
            if token != None:
                self._do_response()
            else:
                self._redirect_to_auth_server()

def run(server_class=HTTPServer, handler_class=TestRequestHandler):
    server_address = ('0.0.0.0', PORT)
    print("python example app")
    print("url: http://%s:%s" % server_address)
    print("gatehouse_url: %s" % GATEHOUSE_URL)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()

run()
