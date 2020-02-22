const sinon = require('sinon');
const service = require('../../service/service');
const getProductEndpoint = require('./index');

const mockResponse = () => {
  const res = {};
  res.json = jest.fn().mockReturnValue(res);
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
});
