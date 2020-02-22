const getInitialEndpoint = require('./index');

const mockResponse = () => {
  const res = {};
  res.send = jest.fn();
  return res;
};

describe('getInitialEndpoint', () => {
  it('should return Ok!', async () => {
    const res = mockResponse();

    getInitialEndpoint(null, res);

    expect(res.send).toHaveBeenCalledWith('Ok!');
  });
});
