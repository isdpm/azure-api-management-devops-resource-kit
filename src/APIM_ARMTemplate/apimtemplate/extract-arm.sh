#!/bin/bash
PROJECT_ROOT=`dirname $(pwd)`

docker  run -v $PROJECT_ROOT/deploy:/extracted \
            -v ~/.azure:/root/.azure \
            apitemplate \
            extract \
            --sourceApimName sdp-apim \
            --destinationApimName sdp-apim \
            --resourceGroup csp-gateway-proving-apimgmt \
            --fileFolder /extracted \
            --splitAPIs "true"