class Settings
  include Singleton

  class << self
    def env;         all[Rails.env];     end;
    def development; all['development']; end;
    def test;        all['test'];        end;
    def production;  all['production'];  end;

    def all
      return instance._all unless Rails.env.production?
      @all ||= instance._all
    end
  end;



  def _all
    s = File.read("#{Rails.root}/config/settings.yml")
    YAML.load(s)
  end
  
end