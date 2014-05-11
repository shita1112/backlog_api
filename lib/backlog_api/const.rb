# -*- coding: utf-8 -*-
module BacklogApi
  # BacklogApi::Command,BacklogApi::Clientで利用するからここがいいのかなー?
  API_METHODS = YAML.load_file(File.expand_path(File.join('../..', 'data', 'api_methods.yml'), __FILE__))
end
