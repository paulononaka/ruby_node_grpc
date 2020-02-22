const sinon = require('sinon');
const protoClient = require('../protos/proto_client');
const service = require('./service');

describe('service.getDiscount()', () => {
  afterEach(() => {
    sinon.restore();
  });

  it('should return the response of protoClient.getDiscount when err is null', async () => {
    sinon.stub(protoClient, 'getDiscount').callsFake((a, responseFunction) => {
      const err = null;
      const response = 'ok!';
      return responseFunction(err, response);
    });

    const response = await service.getDiscount();

    expect(response).toBe('ok!');
  });

  it('should throw an error when protoClient.getDiscount fails', async () => {
    sinon.stub(protoClient, 'getDiscount').callsFake((a, responseFunction) => {
      const err = 'some error';
      const response = 'some response';
      return responseFunction(err, response);
    });

    let errorMensage = null;
    try {
      await service.getDiscount();
    } catch (e) {
      errorMensage = e;
    }
    expect(errorMensage).toBe('some error');
  });
});
