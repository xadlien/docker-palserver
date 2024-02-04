# docker-palserver

## Description  
This repo contains code to build and deploy a docker image containing a PalWorld Dedicated server. `docker-compose` is used to deploy the image. Please see [this link](https://low.ms/knowledgebase/server-configuration-for-palworld) on what each server setting does. Every configuration option is configurable via environment variables when running the image, which you can see in the example docker-compose file.

## Usage  
1. First edit `docker-compose.yml` to have the settings you want.
2. Lastly, deploy using `docker-compose up -d` 

## Private Usage on the Internet
When using this for a private server over the internet for others I recommend setting the following options:
1. `SERVER_PASSWORD` (for obvious reasons, and it works after an update)
2. `PUBLIC_IP` (you can get this by typing in `whats my ip?` on google)
3. `BANLIST_URL` (This should be kept at the default)

## Performance Tuning
Here are a few ways to help with performance. As an estimate, my server with 4 people in the same guild reached about 12 GB of ram usage after about a week with mostly default parameters.
1. `DROPITEM_ALIVEMAXHOURS`: a lower number will allow for less time before items dissappear
2. `DROPITEM_MAXNUM`: a lower number will allow less items laying on the ground
3. `ACTIVE_UNKO`: leave it false
4. `DROPITEM_MAXNUM_UNKO`: if ACTIVE_UNKO is True, less will allow for less items being generated
5. `services.palserver.deploy.resources.limits.memory`: in `docker-compose.yml` you can limit the memory used by this app
