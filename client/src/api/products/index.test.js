const sinon = require('sinon');
const service = require('../../service/service');
const getProductEndpoint = require('./index');
const repository = require('../../repository/repository');

const mockResponse = () => {
  const res = {};
  res.json = jest.fn().mockReturnValue(res);
  res.status = jest.fn().mockReturnValue(res);
  return res;
};

const mockQuery = () => {
  const req = {};
  req.query = {};
  req.query.userId = 1;
  return req;
};

describe('getProductEndpoint', () => {
  afterEach(() => {
    sinon.restore();
    mockQuery();
  });

  it('should return the response of all service.getDiscount() promises', async () => {
    const res = mockResponse();
    const req = mockQuery();

    sinon.stub(service, 'getDiscount')
      .onFirstCall()
      .resolves('first promise')
      .onSecondCall()
      .resolves('second promise');

    sinon.stub(repository, 'getProducts').returns([{ id: 1 }, { id: 2 }]);

    await getProductEndpoint(req, res);

    expect(res.json).toHaveBeenCalledWith(['first promise', 'second promise']);
  });

  it('should return the response even if service.getDiscount() fails', async () => {
    const res = mockResponse();
    const req = mockQuery();

    sinon.stub(service, 'getDiscount').throws();

    let message;
    try {
      await getProductEndpoint(req, res);
    } catch (e) {
      message = e;
    }

    expect(message).not.toBeTruthy();
  });

  it('returns the product list but with zero discounts for the affected products if service 1 fails, ', async () => {
    const res = mockResponse();
    const req = mockQuery();

    sinon.stub(service, 'getDiscount').throws();
    sinon.stub(repository, 'getProducts').returns(['products']);

    await getProductEndpoint(req, res);

    expect(res.json).toHaveBeenCalledWith(['products']);
  });
});
