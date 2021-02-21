<template>
  <div class="container">
    <header>
      <h1>Correto Cavalo Bateria Grampo</h1>
      <p>Gerando senhas seguras e fáceis de lembrar</p>
    </header>

    <div class="password-input">
      <input :value="generatedPassword" disabled type="text" class="input">
      <button @click="genPassword">
        Gerar senha
      </button>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      generatedPassword: 'correto.cavalo.bateria.grampo'
    }
  },
  methods: {
    genPassword () {
      this.generatedPassword = 'baleia.controle.analise.mercado'
    }
  }
}
</script>

<style>
header {
  @apply py-4
}
.container {
  @apply min-h-screen flex flex-col justify-center text-center mx-auto px-2;
}
h1 {
  @apply text-2xl mb-3
}
p {
  @apply mb-2
}
.password-input {
  @apply flex-grow flex flex-col justify-center
}
.input {
  @apply rounded-md py-3 px-6 w-full max-w-lg text-center mb-4
}
button {
  @apply rounded-md py-2 px-6 border
}
</style>
