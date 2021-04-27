// app/javascript/plugins/vee-validate.js
import { ValidationProvider, ValidationObserver, extend } from "vee-validate";
import { required, max, regex } from "vee-validate/dist/rules";

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
  message: "{_field_}は最大{length}文字だよ",
});

extend("max_no_field", {
  ...max,
  message: "最大{length}文字で入力してね",
});

extend("regex_postcode", {
  ...regex,
  message: "正しい{_field_}を入力してね",
});

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
};
