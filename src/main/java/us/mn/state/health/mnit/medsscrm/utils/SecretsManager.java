package us.mn.state.health.mnit.medsscrm.utils;

import com.amazonaws.services.secretsmanager.AWSSecretsManager;
import com.amazonaws.services.secretsmanager.AWSSecretsManagerClientBuilder;
import com.amazonaws.services.secretsmanager.model.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import us.mn.state.health.mnit.medsscrm.data.ClientSecret;

import java.util.Base64;

public class SecretsManager {

    private static String retrieveSecret(String region, String secretName) {
            AWSSecretsManager client  = AWSSecretsManagerClientBuilder.standard()
                    .withRegion(region)
                    .build();

            String secret = null;
            String decodedBinarySecret = null;

            GetSecretValueRequest getSecretValueRequest = new GetSecretValueRequest()
                    .withSecretId(secretName);
            GetSecretValueResult getSecretValueResult = null;

            try {
                getSecretValueResult = client.getSecretValue(getSecretValueRequest);
            } catch (DecryptionFailureException | InternalServiceErrorException | InvalidParameterException |
                    InvalidRequestException | ResourceNotFoundException e) {
                e.printStackTrace();
                throw e;
            }

            if (getSecretValueResult.getSecretString() != null) {
                secret = getSecretValueResult.getSecretString();
                return secret;
            } else {
                decodedBinarySecret = new String(Base64.getDecoder().decode(getSecretValueResult.getSecretBinary()).array());
                return decodedBinarySecret;
            }
    }

    public static ClientSecret getClientSecret(String region, String secretName) {
        String secret = retrieveSecret(region, secretName);
        try {
            return new ObjectMapper().readValue(secret, ClientSecret.class);
        } catch (JsonMappingException e) {
            e.printStackTrace();
            return null;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }
}
