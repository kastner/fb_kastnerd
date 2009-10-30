class Kastnerd
  module Views
    class Layout < Mustache
      def title 
        @title || "Welcome to kastnerd"
      end
      
      def fb_connect
        <<-SCRIPT
        <script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US" type="text/javascript"></script><script type="text/javascript">FB.init("cfcb4074816252b026f6601ba9900e24");</script>
        SCRIPT
      end
    end
  end
end