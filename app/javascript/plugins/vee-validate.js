// app/javascript/plugins/vee-validate.js
import { ValidationProvider, ValidationObserver, extend } from "vee-validate";
import { required, max } from "vee-validate/dist/rules";
import moment from "moment";

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

extend("available_age", (value) => {
  const birthday = moment(new Date(value));
  const today = moment(new Date());
  const age = birthday.diff(today, "years");
  if (age >= -70 && age <= -18) {
    return true;
  }
  return "18歳から70歳までしか入力できないよ";
});

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
};
