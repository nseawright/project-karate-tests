function fn() {
    var env = karate.env; // get java system property 'karate.env'

    if (!env) { // env default 'STG'
        env = 'STG';
    }

    var environments = {
        STG: {
            url: 'http://host.stg.intranet.test/users',
            apiKey: 'stg-487563833784329442'
        },
        QA: {
            url: 'http://host.qa.intranet.test/users',
            apiKey: 'uat-424289857242984248'
        }
    }

    var config = {
        ApiUrl: environments[env].url,
        XApiKey: environments[env].apiKey
    }

    karate.log('karate.env: ', env);

    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);

    return config;
}
