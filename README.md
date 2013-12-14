Selenium Installation Instructions
=========================
First install Chrome:
---
1. add Linux-repository public key from Google:
`wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -`

2. sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

3. Then run `sudo apt-get update`

4. And finally `sudo apt-get install google-chrome-stable`

Second, install xvfb
---
`apt-get -y install xvfb\
  x11-xkb-utils\
  xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic\
  xserver-xorg-core`

Third, install ChromeDriver
---
Download:
`curl -O https://chromedriver.googlecode.com/files/chromedriver_linux32_26.0.1383.0.zip`

Unzip:
`unzip chromedriver_linux32_26.0.1383.0.zip`

Put the chomedriver executable under path:
`sudo mv chromedriver /usr/local/bin`

Remove the zip file:
`rm chromedriver_linux32_26.0.1383.0.zip`

Ready!
---
You are now ready to run `ruby run.rb`