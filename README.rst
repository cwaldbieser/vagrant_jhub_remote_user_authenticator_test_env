====================================================================
Vagrant Testing Environment for Jupyterhub Remote User Authenticator
====================================================================

If you have Vagrant set up with a VirtualBox backend, bring up a working
test environment with:

.. code::shell

    $ vagrant up

Port 8080 on the local machine will be forwarded to the test environment.
Apache httpd will act as a proxy to the hub and use Basic Authentication
to authenticate the user.  The authenticated username will be passed to the
hub and used with the RemoteUserAuthenticator.

