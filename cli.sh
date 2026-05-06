ROLLNUMBER="27100104"
RG="rg-sp26-27100104"
REGION="ukwest"


# create asp
az appservice plan create \
    --name "pa4-${ROLLNUMBER}" \
    --resource-group "${RG}" \
    --location "${REGION}" \
    --sku B1 \
    --is-linux


# create wwebapp
ROLLNUMBER="27100104"
RG="rg-sp26-27100104"
REGION="ukwest"

az webapp create \
    --name "pa4-${ROLLNUMBER}" \
    --resource-group "${RG}" \
    --plan "pa4-${ROLLNUMBER}" \
    --runtime "NODE:22-lts"