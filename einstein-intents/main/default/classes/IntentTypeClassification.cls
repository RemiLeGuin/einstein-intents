public with sharing class IntentTypeClassification implements Queueable, Database.AllowsCallouts {

    public Case[] cases;

    public IntentTypeClassification(Case[] cases) {
        this.cases = cases.deepClone(true, true, true);
    }

    public void execute(QueueableContext context) {
        for (Case cs : cases) {
            HttpResponse response = getIntents(cs.Description);
            cs.Type = getCaseTypeFromIntents(response?.getBody());
        }
        update cases;
    }

    private HttpResponse getIntents(String inputText) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');

        //request.setEndpoint('callout:EinsteinPlatform/v2/language/intent');
        request.setEndpoint('https://api.einstein.ai/v2/language/intent');

        StaticResource base64Content = [SELECT Body FROM StaticResource WHERE Name = 'einstein_platform' LIMIT 1];
        String keyContents = base64Content.Body.tostring();
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');
        JWT jwt = new JWT('RS256');
        jwt.pkcs8 = keyContents;
        jwt.iss = 'developer.force.com';
        jwt.sub = 'remileguin@live.fr';
        jwt.aud = 'https://api.einstein.ai/v2/oauth2/token';
        jwt.exp = '120';
        String token = new JWTBearerFlow().getAccessToken('https://api.einstein.ai/v2/oauth2/token', jwt);
        request.setHeader('Authorization', 'Bearer ' + token);

        request.setHeader('Content-type', 'application/json');

        JSONGenerator generator = JSON.createGenerator(false);
        generator.writeStartObject();
        generator.writeStringField('modelId', 'JSAFJOXE77RW4PWAUMAM6J3A3Q');
        generator.writeStringField('document', inputText);
        generator.writeEndObject();
        generator.close();
        request.setBody(generator.getAsString());
        System.debug(request.getBody());

        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        return response;
    }

    private String getCaseTypeFromIntents(String serializedIntents) {
        Intents intents = (Intents) JSON.deserialize(serializedIntents, Intents.class);
        return intents.probabilities[0]?.label;
    }

}