const request = require('supertest');
const app = require('./app');

describe('/product endpoint', () => {
  it('should return a list of products', async () => {
    await request(app)
      .get('/')
      .expect(200)
      .expect('Ok!');
  });
});
