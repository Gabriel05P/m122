#!/bin/bash

 

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Installing..."
  sudo apt-get update
  sudo apt-get install -y jq
fi

 


 

# Fetch JSON data from the API
json=$(curl -s "$API_URL")

 

# Parse JSON data to extract currency values
eur_value=$(echo "$json" | jq -r '.data.EUR.value')
usd_value=$(echo "$json" | jq -r '.data.USD.value')
chf_value=$(echo "$json" | jq -r '.data.CHF.value')
gbp_value=$(echo "$json" | jq -r '.data.GBP.value')

 

# Create HTML file
cat << EOF > currencies.html
<title>Currency Exchange Rates</title>
<style>
    table {
      border-collapse: collapse;
      width: 300px;
      margin: 20px auto;
    }

 

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

 

    th {
      background-color: #f2f2f2;
      font-weight: bold;
    }
    body {
      text-align: center;
    }

 

    * {
      font-family: 'Montserrat', sans-serif;
}
</style>
</head>
<body>
<h1>Currency Exchange Rates</h1>
<table>
<tr>
<th>Currency</th>
<th>Value</th>
</tr>
<tr>
<td>EUR</td>
<td>$eur_value</td>
</tr>
<tr>
<td>USD</td>
<td>$usd_value</td>
</tr>
<tr>
<td>CHF</td>
<td>$chf_value</td>
</tr>
<tr>
<td>GBP</td>
<td>$gbp_value</td>
</tr>
</table>
</body>
</html>

 

EOF

 

echo "HTML file created: currencies.html"

hat Kontextmenü