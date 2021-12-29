public with sharing class EinsteinKeyManagement {

    public EinsteinKeys getKeys(String token) {
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://api.einstein.ai/v2/keys');
        request.setHeader('Authorization', 'Bearer ' + token);
        Http http = new Http();
        HttpResponse response = http.send(request);
        EinsteinKeys keys = null;
        if (response.getStatusCode() == 200) {
            keys = (EinsteinKeys) JSON.deserialize(response.getBody(), EinsteinKeys.class);
        }
        return keys;
    }

    public HttpResponse addKey(String token, String publicKey) {
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://api.einstein.ai/v2/keys');
        request.setHeader('Content-type', 'application/json');
        request.setHeader('Authorization', 'Bearer ' + token);

        JSONGenerator generator = JSON.createGenerator(false);
        generator.writeStartObject();
        generator.writeStringField('publicKey', publicKey);
        generator.writeStringField('name', 'EinsteinPlatform');
        generator.writeBooleanField('active', true);
        generator.writeEndObject();
        generator.close();
        request.setBody(generator.getAsString());
        System.debug(request.getBody());

        Http http = new Http();
        HttpResponse response = http.send(request);
        return response;
    }

    public HttpResponse activateKey(String token, String keyId) {
        HttpRequest request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint('https://api.einstein.ai/v2/keys/' + keyId);
        request.setHeader('Authorization', 'Bearer ' + token);
        Http http = new Http();
        HttpResponse response = http.send(request);
        return response;
    }

    public HttpResponse deleteKey(String token, String keyId) {
        HttpRequest request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('https://api.einstein.ai/v2/keys/' + keyId);
        request.setHeader('Authorization', 'Bearer ' + token);
        Http http = new Http();
        HttpResponse response = http.send(request);
        return response;
    }
}