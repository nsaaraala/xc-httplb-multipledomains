


resource "volterra_malicious_user_mitigation" "tf-demo" {
  
  name      = "${var.namespacempo}-prod-malicious-user"
  namespace = var.namespacempo
  mitigation_type {
    rules {

      threat_level {
        low = true
        
        
      }
      mitigation_action {
        javascript_challenge = true

      }
    }

    rules {
      threat_level {
        medium = true
        
      }
      mitigation_action {
        javascript_challenge = true
      }
    }

    rules{
      threat_level {
        high = true
        
      }
      mitigation_action {
        captcha_challenge = true
      }
    }
  }
  }


resource "volterra_user_identification" "tf-demo" {
  
  name      = "${var.namespacempo}-client-tls-fingerprint"
  namespace = var.namespacempo

  rules {
    ip_and_tls_fingerprint = true
  }
}


resource "volterra_origin_pool" "tf-demo" {
  count = length(var.lb-name)
  name                   = "${element(var.lb-name, count.index)}-origin-pool"
  namespace              = var.namespacempo
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  
  use_tls {
           use_host_header_as_sni = true
         tls_config {
           default_security = true
         }
        volterra_trusted_ca = true
        no_mtls = true
  }
  port                   = 443

  origin_servers {
    
     dynamic "public_name" {
      for_each = var.enable-public-dns-name ? [1] : []
      content {
      dns_name = element(var.public-dns-name, count.index)
     }
   }
     dynamic "public_ip" {
      for_each = var.enable-public-ip-address ? [1] : []
      content {
      ip = element(var.public-ip-address, count.index)
     }
   }
 }
}

resource "volterra_app_firewall" "tf-demo" {
  count = length(var.lb-name)
  name                     = "${element(var.lb-name, count.index)}-waf"
  namespace                = var.namespacempo
  allow_all_response_codes = true
}


resource "volterra_http_loadbalancer" "tf-demo" {
  count = length(var.lb-name)
  name                            = element(var.lb-name, count.index)
  namespace                       = var.namespacempo
  //description                     = format("HTTPS loadbalancer object for %s origin server", var.web_app_name)
  domains                         = element(var.domains, count.index)
  advertise_on_public_default_vip = true
  disable_waf                     = false
  disable_rate_limit              = false
  round_robin                     = true
  service_policies_from_namespace = true
  no_challenge                    = false
  

  //default_route_pools  {
  //  pool {
  //    name      = volterra_origin_pool.tf-demo.name
  //    namespace = var.namespacempo
  //  }
  //}
  
  dynamic "routes" {
    
    for_each = element(var.domains, count.index)
    content {
      simple_route {
        
        
        http_method = "ANY"
        path {
          prefix = "/"
        }
        
       
        headers {
         name = "Host"
         exact = routes.value
         invert_match = false
         
        } 
        origin_pools {
          pool {
            
            name      = "${element(var.lb-name, count.index)}-origin-pool"
            namespace = var.namespacempo
          }
        }
        host_rewrite = routes.value
      }
    }
  }
  
  dynamic "bot_defense" {
    for_each = var.enable_bot_defense_standard ? [1] : []
    content {
      regional_endpoint = var.bot_region["key3"]
      policy {
        js_download_path = var.bot_js_path
        javascript_mode  = var.bot_mode["key1"]
       
        js_insert_all_pages {
          javascript_location = var.bot_js_tag_location[0]
        }

            

        dynamic "protected_app_endpoints" {
          for_each = var.endpoint-name
          content {
            metadata {
              name    = var.endpoint-name[protected_app_endpoints.key]
              disable = false
            }
            http_methods = [var.bot_method_type[1]]
            flow_label {
              authentication {
                login {
                  disable_transaction_result = false
                }
              }
            }
            protocol   = "BOTH"
            any_domain = true
            path {
              prefix = var.endpoint-path[protected_app_endpoints.key]
            }
            web = true
            mitigation {
              flag {
                no_headers = true
              }
            }
            allow_good_bots = true
          }
        }
      }
    }
  }
  


  https_auto_cert {
    add_hsts      = var.enable_hsts
    http_redirect = var.enable_redirect
    no_mtls       = true
  }

  app_firewall {
    
    name      = "${element(var.lb-name, count.index)}-waf"
    namespace = var.namespacempo
  }

  slow_ddos_mitigation{
    request_headers_timeout = "10000"
    request_timeout         = "60000"
  }
  
  user_identification {
     namespace = var.namespacempo
     name      = "${var.namespacempo}-client-tls-fingerprint"
     
      
     }
  

  enable_ip_reputation{

    ip_threat_categories = var.ipreputation
  }
  enable_challenge { 

  malicious_user_mitigation {
    
    namespace = var.namespacempo
    name = "${var.namespacempo}-prod-malicious-user"
  }
  
  }
  depends_on = [ volterra_app_firewall.tf-demo,volterra_origin_pool.tf-demo ]
}


  


  

  
  