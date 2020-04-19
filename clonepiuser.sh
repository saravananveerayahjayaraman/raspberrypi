#Script to replace pi user with another user login name (*** Should not create this user. User must not exist in raspberrypi***)
#Taking backup of all files being changed in /etc folder.
cd /etc
sudo tar -cvf authfiles.tar passwd group shadow gshadow sudoers subuid subgid l$
#Replacing all 'pi' references to new user references.
sudo sed -i.$(date +'%y%m%d_%H%M%S') 's/\b'$1'\b/'$2'/g' passwd group shadow gs$
#Replacing 'pi' reference in the LightDM desktop with new user
sudo sed -i.$(date +'%y%m%d_%H%M%S') 's/user='$1'/user='$2'/' lightdm/lightdm.c$
#Renaming/Moving Directory from 'pi' to new user
sudo mv /home/$1 /home/$2
#Create a softlnk so that any  other references are not broken
sudo ln -s /home/$2 /home/$1
sudo mv -v /var/spool/cron/crontabs/$1 /var/spool/cron/crontabs/$2
