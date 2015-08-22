#!/bin/bash

log() {
  echo "`date +"%m/%d/%Y %T"` $1"
}

ahem() {
  afplay Downloads/ahem_x.wav
}

restart_wifi() {
  echo -n "`date +"%m/%d/%Y %T"` Restarting wifi..."
  networksetup -setairportpower en0 off
  sleep 1
  networksetup -setairportpower en0 on
  sleep 2
  echo " done."
}

logout() {
  curl 'https://guestauth.baptisthealth.net/logout.html' -H 'Pragma: no-cache' -H 'Origin: https://guestauth.baptisthealth.net' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8,es;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Referer: https://guestauth.baptisthealth.net/logout.html' -H 'Cookie: nmstat=1440185795347; _ga=GA1.2.660828208.1440185708' -H 'Connection: keep-alive' --data 'userStatus=1&err_flag=0&err_msg=' --compressed > /tmp/baptist_logout.html
}

login() {
  echo -n `date +"%m/%d/%Y %T"`" Logging in..."
  curl 'http://google.com/' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,es;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36' -H 'X-Chrome-UMA-Enabled: 1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Cookie: PREF=ID=1111111111111111:FF=0:LD=en:TM=1423765744:LM=1435174387:GM=1:S=LYuaIxbQSjMvV-uT; SID=DQAAAEMBAACCMiYLsyvyd55S43zMOShxpSVOO0FsgZO_U6vIK7SEeMrqv3SQg_cH6GhoDFEZNCYt2b8jZ8wAH3Kudtinb4UAuo79CziCEBqx1uyBqgd_EzwLzfNKkDY9UaGbgsx66HoDPAhA-9gia3eBMjQAsrL89_lWyz1QDraflinU1NZLUna-rX0Os9h3Oq5Qc0fL4u3zGq4yp0k5XQluX130E8nWKciFF0vNLqSUKhmkVJukZWyHOQHw5ICTZ4I84IuwAe3BNt8GUy28VbJN74v8gaWrurKMBeVVmrhGrGEkMcXV7MhEXO0pKGsWbGvB7-4Z2rhA47FqtC6WgVQN5yks5PKFaIcwnkNVihEusbsNPw4yoajLIiCH6osytsyFNHUj77iCW_TVDJlop30D50cdXEAUo70PFWSz2Rbyax9LrCGi6wkZjWrwZ5tHuC6TxRy_Wbs; HSID=Ab3PWeIzJbM04XSaL; APISID=XxTSgD-r8BrvktA6/A3noKLmThJm0s9zN2; NID=70=NupeU3Ht2RK-M-yQq7Q0o-MDIFwehh0JTvCZs_L_Mf4loxszYQvHhjplkSscpu20Oz2xa50iBnNCS0mibWda2s_LMO9K2cFDhOTooJvw-Q1VdP_EfMPOPWWVvVdHJDHA55i6ByC4JwIzzG3SvvXSM8QspB_xahGh5XEQkCMVTEJa02OZj4_X6x2qTGXerf6l9pie0B_QW0rpOrhsY1BKiki9HYMzSqQO6g-X' -H 'X-Client-Data: CKe1yQEIjbbJAQiltskBCKm2yQEIwbbJAQjwiMoB' -H 'Connection: keep-alive' --compressed &> /tmp/baptist_login_1.html
  curl 'https://guestauth.baptisthealth.net/login.html?redirect=google.com/' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,es;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://google.com/' -H 'Cookie: nmstat=1440185795347; _ga=GA1.2.660828208.1440185708' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed  &> /tmp/baptist_login_2.html
  curl 'https://guestidm.baptisthealth.net/portal/10.11.60.3/?switch_url=https://guestauth.baptisthealth.net/login.html&ap_mac=00:18:74:0b:3b:c0&wlan=Baptist%20Health%20Wi-Fi%20Guest%20Net&redirect=google.com/' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,es;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Cookie: name=cookieTest2620494444014; nmstat=1440185795347; _ga=GA1.2.660828208.1440185708' -H 'Connection: keep-alive' --compressed  &> /tmp/baptist_login_3.html
  curl 'https://guestauth.baptisthealth.net/login.html' -H 'Pragma: no-cache' -H 'Origin: https://guestidm.baptisthealth.net' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8,es;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Referer: https://guestidm.baptisthealth.net/portal/10.11.60.3/?switch_url=https://guestauth.baptisthealth.net/login.html&ap_mac=00:18:74:0b:3b:c0&wlan=Baptist%20Health%20Wi-Fi%20Guest%20Net&redirect=google.com/' -H 'Cookie: nmstat=1440185795347; _ga=GA1.2.660828208.1440185708' -H 'Connection: keep-alive' --data 'username=TrVRav95&password=BB5ihvP0&buttonClicked=4&redirect_url=https%3A%2F%2Fguestidm.baptisthealth.net%2Fportal%2FGuestNetwork%2F10.11.60.3%2Fsuccess' --compressed  &> /tmp/baptist_login_4.html
  sleep 1
  echo " done."
}

verify() {
  echo -n `date +"%m/%d/%Y %T"`" Verifying..."
  curl http://captive.apple.com/hotspot-detect.html &> /tmp/baptist_check
  grep -q "Success" /tmp/baptist_check
  local result=$?
  echo " done."
  return $result
}

while true
do
  # ping -c 1 -n 192.168.88.254 &> /dev/null
  verify
  if [ `echo $?` != 0 ]
  then
    ahem
    log "We're down. :("
    exit
    # restart_wifi
    # login
    # verify
    # if [ `echo $?` != 0 ]
    # then
    #   echo `date +"%m/%d/%Y %T"`" ...sorry, something went wrong. :("
    #   exit
    # else
    #   echo `date +"%m/%d/%Y %T"`" ...and we're back. :)"
    # fi
    # sleep 1
  else
    sleep 30
  fi
done


