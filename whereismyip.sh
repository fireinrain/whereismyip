#bin/sh

# bash script for get ip from whatismyip
# author sunrise
# date 2021-08-29

# shellcheck disable=SC1073
whereismyip(){
  infoHtml=$(curl -s https://www.whatismyip.com/my-ip-information/)

  # get ip info part
  ipInfo=$(echo "$infoHtml" | grep -E "My Public IPv4 is:" |grep -Eo "(([01]{0,1}\d{0,1}\d|2[0-4]\d|25[0-5])\.){3}([01]{0,1}\d{0,1}\d|2[0-4]\d|25[0-5])" | head -1)
  if [ -z "$ipInfo" ]; then
      ipInfo="Ip: unKnow"
  fi

  # get ip location info part
  ipLocationInfo=$(echo "$infoHtml" | grep -E "City:|State:|Country:|Postal Code:|Time Zone:")

  City=$(echo "$ipLocationInfo" | grep -Eo "City: (.)*>$")
  State=$(echo "$ipLocationInfo" | grep -Eo "State: (.)*>$")
  Country=$(echo "$ipLocationInfo" | grep -Eo "Country: (.)*>$")
  PostalCode=$(echo "$ipLocationInfo" | grep -Eo "Postal Code: (.)*>$")
  TimeZone=$(echo "$ipLocationInfo" | grep -Eo "Time Zone: (.)*>$")
  # test if the value is empty str
  if [ -z "$City" ]; then
      City="City: unKnow"
  fi
  if [ -z "$State" ]; then
      State="State: unKnow"
  fi
  if [ -z "$Country" ]; then
      Country="Country: unKnow"
  fi
  if [ -z "$PostalCode" ]; then
      PostalCode="PostalCode: unKnow"
  fi
  if [ -z "$TimeZone" ]; then
      TimeZone="TimeZone: unKnow"
  fi

  # get isp part info
  ipHostNameInfo=$(echo "$infoHtml" | grep -E "ISP:|Host Name:|ASN:")

  ISP=$(echo "$infoHtml" | grep -Eo "ISP: (.)*>$")
  HostName=$(echo "$infoHtml" | grep -Eo "Host Name: (.)*>$")
  ASN=$(echo "$infoHtml" | grep -Eo ">\d{1,}<")
  ASNR=${ASN:1}
  # test if the value is empty str
  if [ -z "$ISP" ]; then
      ISP="ISP: unKnow"
  fi
  if [ -z "$HostName" ]; then
      HostName="HostName: unKnow"
  fi
  if [ -z "$ASNR" ]; then
      ASNR="ASN: unKnow"
  fi


  echo "--------------Your Ip Information--------------"
  echo "Ip: ""$ipInfo"
  echo "--------------Location Information-------------"
  echo "${Country%</li>}"
  echo "${State%</li>}"
  echo "${City%</li>}"
  echo "${PostalCode%</li>}"
  echo "${TimeZone%</li>}"
  echo "----------------ISP Information----------------"
  echo "${ISP%</li>}"
  echo "${HostName%</li>}"
  echo "ASN: ${ASNR%<}"
  echo "---------------------End-----------------------"

  exit 0
}

whereismyip

