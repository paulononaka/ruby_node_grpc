const request = require('supertest');
const app = require('./app');

describe('app', () => {
  it('/ endpoint should return 200', async () => {
    await request(app)
      .get('/')
      .expect(200)
      .expect('Ok!');
  });
});
