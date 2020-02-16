const request = require('supertest');
const app = require('../app');

describe('/ endpoint', () => {
  it('should return Ok! message', async () => {
    await request(app)
      .get('/')
      .expect(200)
      .expect('Ok!');
  });
});
