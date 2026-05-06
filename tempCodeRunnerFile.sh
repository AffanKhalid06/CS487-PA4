ROLLNUMBER="27100104"
RG="rg-sp26-27100104"
REGION="ukwest"

az webapp create \
    --name "pa4-${ROLLNUMBER}" \
    --resource-group "${RG}" \
    --plan "pa4-${ROLLNUMBER}" \
    --runtime "NODE:22-lts"