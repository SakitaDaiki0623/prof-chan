// app/javascript/plugins/vee-validate.js
import { ValidationProvider, ValidationObserver, extend } from "vee-validate";
import { required, max } from "vee-validate/dist/rules";

extend("input_required", {
  ...required,
  message: "{_field_}を入力してね",
});

extend("select_required", {
  ...required,
  message: "{_field_}を選択してね",
});

extend("max", {
  ...max,
  message: "{_field_}は最大{length}文字です",
});

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
};
