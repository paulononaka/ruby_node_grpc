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

describe('getProductEndpoint', () => {
  afterEach(() => {
    sinon.restore();
  });

  it('should return the response of service.getDiscount()', async () => {
    const res = mockResponse();
    sinon.stub(service, 'getDiscount').resolves('ok');

    await getProductEndpoint(null, res);

    expect(res.json).toHaveBeenCalledWith('ok');
  });

  it('should return the response even if service.getDiscount() fails', async () => {
    const res = mockResponse();
    sinon.stub(service, 'getDiscount').throws();

    let message;
    try {
      await getProductEndpoint(null, res);
    } catch (e) {
      message = e;
    }

    expect(message).not.toBeTruthy();
  });

  it('returns the product list but with zero discounts for the affected products if service 1 fails, ', async () => {
    const res = mockResponse();
    sinon.stub(service, 'getDiscount').throws();
    sinon.stub(repository, 'getProducts').returns(['products']);

    await getProductEndpoint(null, res);

    expect(res.json).toHaveBeenCalledWith(['products']);
  });
});
