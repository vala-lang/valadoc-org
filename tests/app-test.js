var chai = require('chai');
var chaiHttp = require('chai-http');
var expect = chai.expect;

chai.use(chaiHttp)

var server = 'http://0.0.0.0:7777'

it('should serve the main page', function(done) {
  chai.request(server)
    .get('/')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'text/html; charset=UTF-8');
      expect(res).to.have.header('ETag');
      done();
    });
});

it('should serve the markup page', function(done) {
  chai.request(server)
    .get('/markup.htm')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'text/html; charset=UTF-8');
      expect(res).to.have.header('ETag');
      done();
    });
});

it('should serve package index', function(done) {
  chai.request(server)
    .get('/glib-2.0/index.htm')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'text/html; charset=UTF-8');
      expect(res).to.have.header('ETag');
      done();
    });
});

it('should serve package devhelp', function(done) {
  chai.request(server)
    .get('/glib-2.0/glib-2.0.tar.bz2')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'application/x-bzip-compressed-tar');
      expect(res).to.have.header('ETag');
      done();
    });
})

it('should serve package symbol', function(done) {
  chai.request(server)
    .get('/glib-2.0/GLib.strdup.html')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'text/html; charset=UTF-8');
      expect(res).to.have.header('ETag');
      done();
    });
});

it('should serve search results in plain text', function(done) {
  chai.request(server)
    .get('/search?query=GLib')
    .set('Accept', 'text/plain')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'text/plain; charset=UTF-8');
      done();
    });
});

it('should produce 404 on missing package in search', function(done) {
  chai.request(server)
    .get('/search?query=Foo&package=foo-1.0')
    .end(function(err, res) {
      expect(res).to.have.status(404);
      expect(res).to.have.header('Content-Type', 'text/html; charset=UTF-8');
      done();
    });
});

it('should serve search results in JSON', function(done) {
  chai.request(server)
    .get('/search?query=GLib')
    .set('Accept', 'application/json')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'application/json');
      expect(res.body[0]).to.have.property('path');
      expect(res.body[0]).to.have.property('name');
      expect(res.body[0]).to.have.property('description');
      done();
    });
});

it('should produce 404 on missing package in search in JSON', function(done) {
  chai.request(server)
    .get('/search?query=Foo&package=foo-1.0')
    .set('accept', 'application/json')
    .end(function(err, res) {
      expect(res).to.have.status(404);
      expect(res).to.have.header('Content-Type', 'application/json; charset=UTF-8');
      done();
    });
});

it('should serve tooltip in plain text', function(done) {
  chai.request(server)
    .get('/tooltip?fullname=glib-2.0/GLib.strdup')
    .set('Accept', 'text/plain')
    .end(function(err, res) {
      expect(res).to.have.status(200);
      expect(res).to.have.header('Content-Type', 'text/plain; charset=UTF-8');
      done();
    });
});

it('should produce 404 on missing tooltip package', function() {
  chai.request(server)
    .get('/tooltip?fullname=foo-1.0/Bar')
    .set('Accept', 'text/plain')
    .end(function(err, res) {
      expect(res).to.have.status(404);
      expect(res).to.have.header('Content-Type', 'text/plain; charset=UTF-8');
      done();
    });
})

it('should produce 404 on missing tooltip symbol', function() {
  chai.request(server)
    .get('/tooltip?fullname=glib-2.0/Bar')
    .set('Accept', 'text/plain')
    .end(function(err, res) {
      expect(res).to.have.status(404);
      expect(res).to.have.header('Content-Type', 'text/plain; charset=UTF-8');
      done();
    });
})
