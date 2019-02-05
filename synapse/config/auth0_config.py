# -*- coding: utf-8 -*-
# Copyright 2018 Aloha Health Network
#
# Based on previous work in jwt_config.py
# Copyright 2015 Niklas Riekenbrauck
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from ._base import Config, ConfigError

class Auth0Config(Config):
    def read_config(self, config):
        auth0_config = config.get("auth0_config", None)
        if auth0_config:
            self.auth0_enabled = auth0_config.get("enabled", False)
            self.auth0_tenant_domain = auth0_config["tenant_domain"]
            self.auth0_client_id = auth0_config["client_id"]
            self.auth0_username = auth0_config.get("username", "nickname")

            try:
                from jose import jwt
                jwt  # To stop unused lint.
            except ImportError:
                raise ConfigError("Missing jwt library. This is required for Auth0 login. Install by running: pip install python-jose")
        else:
            self.auth0_enabled = False
            self.auth0_tenant_domain = None
            self.auth0_client_id = None
            self.auth0_username = None

    def default_config(self, **kwargs):
        return """\
        #  (subject) claim.
        #
        # auth0_config:
        #   enabled: true|false
        #   tenant_domain: 'tenant.auth0.com'
        #   client_id: 'XXXXXX'
        #   username: 'nickname'|'https://custom.oidc/claim'
        """
