<template>
  <div>
    <div class="balloon1">
      {{ placeNumber }}位はまだいないよ
    </div>
    <img
      src="../../images/prof_normal.png"
      class="image"
    >
  </div>
</template>

<script>
export default {
  props: {
    placeNumber: {
      type: String,
      required: true,
    },
  },
};
</script>

<style scoped>
.balloon1 {
  position: relative;
  display: inline-block;
  padding: 10px 10px;
  min-width: 170px;
  color: #795548;
  background: #e0edff;
  border-radius: 15px;
  font-size: 2rem;
}

.balloon1:before {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -15px;
  border: 15px solid transparent;
  border-top: 15px solid #e0edff;
}

.image {
  max-width: 15rem;
}
</style>
