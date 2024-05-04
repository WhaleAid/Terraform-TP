# install docker

sudo yum update
sudo yum search docker
sudo yum info docker
sudo yum -y install docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker.service
sudo systemctl start docker.service

# install git
sudo yum install git -y

# clone repository
git clone https://github.com/alexdieudonne/webos.git

# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install node

# launch the app
cd webos
npm install
npm run dev --host &