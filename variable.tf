
############## Need to change the variables############
//////////////// Load Balancer Configuration ///////
variable "namespacempo" {
  type    = string
  default = "terrafrom12-mpotech"
}

// lb name and waf,malicious user, client-tls, pool name starts with lb-name only
variable "lb-name" {
  description = "set of lb names"
  type        = list
  default     = ["terraform-web8","terraform-web9","terraform-web10"]
}



 variable "domains" {
  description = "set of domain names"
  type        = list
  default     = [["test8.xc.naveen.com", "test9.xc.naveen.com","test10.xc.naveen.com"],["test11.xc.naveen.com","test12.xc.naveen.com"],["test13.xc.naveen.com"]]
}



//select dafult as "true" if you mentioned IP address here otherwise set to "false"


variable "enable-public-ip-address" {
  type    = bool
  default = true
}

variable "public-ip-address" {
  type    = list(string)
  default = ["1.2.3.4","2.3.4.5","3.4.5.6"]
}


//select dafult as true if you mentioned DNS name here otherwise set to "false"
variable "enable-public-dns-name" {
  type    = bool
  default = false
}
variable "public-dns-name" {
  type    = list(string)
  default = ["test1-origin.com","test6-origin.com","test3-origin.com"]
}





//BOT DEFENSE GLOBAL JS request

variable "bot_js_path" {
  type        = string
  default     = "/baikjriu.js"
  description = "The JS path"
}


//Protected Endpoints

variable "endpoint-name" {
 type        = list(string)
  default    = ["login-endpoint","register-endpoint"]
}

variable "endpoint-path" {
  type        = list(string)
  default = ["/doLogin","/register"]
}

// Entrypages 

variable "js-getpages-name" {
  type        = list(string)
  default = ["get-login","reg-login"]
}

variable "js-getpages-prefix" {
  type        = list(string)
  default = ["/doLogin","/register"]
}





########### NO Need to change ##########


//Custom malicious user configuration

variable "custom-malicious_user_mitigation" {
  type    = string
  default = "ves-io-default-malicious-user-mitigation"
}

//IP reputation

variable "ipreputation" {
  type        = list(string)
  default     = ["SPAM_SOURCES", "WINDOWS_EXPLOITS","WEB_ATTACKS","BOTNETS","SCANNERS","REPUTATION","PHISHING","PROXY","TOR_PROXY","MOBILE_THREATS","DENIAL_OF_SERVICE","NETWORK"]
}

variable "enable_hsts" {
  type        = bool
  description = "Flag to enable hsts for HTTPS loadbalancer"
  default     = false
}

variable "enable_redirect" {
  type        = bool
  description = "Flag to enable http redirect to HTTPS loadbalancer"
  default     = true
}

variable "bot_js_tag_location" {
  type = list(string)
  default = [
    "AFTER_HEAD",
    "AFTER_TITLE_END",
    "BEFORE_SCRIPT"
  ]
}

variable "bot_method_type" {
  type    = list(string)
  default = ["METHOD_ANY", "METHOD_POST", "METHOD_GET", "METHOD_GET_DOCUMENT", "METHOD_PUT"]
}


// BOT DEFENSE 

variable "enable_bot_defense_standard" {
  type        = bool
  default     = true
  description = "Do you want to enable BOT Defense Standard (True or False)"
}

variable "bot_region" {
  type = map(string)
  default = {
    key1 = "EU"
    key2 = "US"
    key3 = "ASIA"
  }
}

variable "bot_mode" {
  type = map(string)
  default = {
    key1 = "ASYNC_JS_NO_CACHING"
    key2 = "ASYNC_JS_CACHING"
    key3 = "SYNC_JS_NO_CACHING"
    key4 = "SYNC_JS_CACHING"
  }
}

