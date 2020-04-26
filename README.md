# Third Party Plugin to install Ghost CMS on FreeNAS easily.

- MySQL database
- NGINX reverse proxy. HTTP redirects to HTTPS
- SSL enabled. Self-signed
- Use sqlite3 database
- DCHP settings
- letsencrypt script

# Installation

On FreeNAS root shell:

    curl -o /tmp/ghost.json https://raw.githubusercontent.com/waterlou/iocage-plugin-ghost/master/ghost.json
    iocage fetch -P /tmp/ghost.json

Then you should able to see Ghost page at `Plugins -> ghost -> Manage`

# Post Installation

By default, the plugin use localhost as the default URL, that will break most links in Ghost.  You should set the url to the FreeNAS.  e.g. http://freenas.local:2368 or http://192.168.1.11:2368

TODO:
    
    Setup Port forward in router

To change this setting, run the following in the root shell:

    iocage set -P url=http://192.168.1.208 ghost

TODO:

    Instruction to mount content path

TODO:

    Setup Letsencrypt


TODO:
    Check why use https in config cause endless loop
     
# Settings

Ghost is stored in:

    /usr/local/share/ghost

Content is stored in:

    /usr/local/share/ghost/content

that you can mount to external storage.

# References

<https://linoxide.com/linux-how-to/install-ghost-nginx-freebsd-10-2/>  
<https://www.ixsystems.com/documentation/freenas/11.3-U2/plugins.html#create-a-plugin>


