#to be used on protocolsource (change entrypoint below in Dockerfile to run other parts)

docker build --tag=inbo/protocols .

#entrypoint_check
docker run --rm --env GITHUB_REPOSITORY="ElsLommelen/protocolsource" --env BRANCH_SOURCE="dockertests" --env PROTOCOL_CODE="sfp-401-nl" --env INPUT_TOKEN inbo/protocols
#INPUT_TOKEN is als omgevingsvariabele toegevoegd op laptop

#entrypoint_update
docker run --rm --env GITHUB_REPOSITORY="ElsLommelen/protocolsource" --env BRANCH_SOURCE="dockertests" --env PROTOCOL_CODE="sfp-401-nl" --env INPUT_TOKEN inbo/protocols

#entrypoint_website
docker run --rm --env GITHUB_REPOSITORY_SOURCE="ElsLommelen/protocolsource" --env BRANCH_SOURCE="dockertests" --env GITHUB_REPOSITORY_DEST="ElsLommelen/protocols" --env INPUT_TOKEN --env GITHUB_ACTIONS=true --env GITHUB_EVENT_NAME=push --env GITHUB_REF=refs/heads/main --env PROTOCOL_CODE="sfp-401-nl" inbo/protocols



#examples
docker build --no-cache --tag=inbobmk/checklist .

docker build --tag=inbobmk/checklist .

docker push inbobmk/checklist

# run on branch
docker run --rm --env GITHUB_REPOSITORY="inbo/checklist" --env GITHUB_SHA=$(git rev-parse HEAD) --env INPUT_TOKEN=$GITHUB_PAT --env INPUT_PATH="." --env ORCID_TOKEN=$ORCID_TOKEN --env CODECOV_TOKEN=$CODECOV_TOKEN inbobmk/checklist
docker run --rm -it --entrypoint=/bin/bash --env GITHUB_REPOSITORY="inbo/checklist" --env GITHUB_SHA=$(git rev-parse HEAD) --env INPUT_TOKEN=$GITHUB_PAT --env INPUT_PATH="." --env ORCID_TOKEN=$ORCID_TOKEN --env CODECOV_TOKEN=$CODECOV_TOKEN inbobmk/checklist

# run on main
docker run --rm --env GITHUB_REPOSITORY="inbo/checklist" --env GITHUB_SHA=$(git rev-parse HEAD) --env GITHUB_PAT=$GITHUB_PAT --env INPUT_PATH="." --env ORCID_TOKEN=$ORCID_TOKEN --env CODECOV_TOKEN=$CODECOV_TOKEN --env GITHUB_ACTIONS=true --env GITHUB_EVENT_NAME=push --env GITHUB_REF=refs/heads/main inbobmk/checklist

