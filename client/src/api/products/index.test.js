const request = require('supertest');
const app = require('../../app');

describe('/product endpoint', () => {
  it('should return a list of product', async () => {
    await request(app)
      .get('/product')
      .expect('Content-Type', /json/)
      .expect(200, [{ product_id: 'Hello world' }]);
  });
});
