<template>
  <div class="container prose">
    <header class="text-center">
      <h1>Correto Cavalo Bateria Grampo</h1>
      <p>Gerando senhas seguras e fáceis de lembrar</p>
    </header>

    <div>
      <h2>Sobre</h2>
      <p>Esse gerador é baseado em uma tira do XKCD: <a href="https://xkcd.com/936/">https://xkcd.com/936/</a></p>
      <p>
        A ideia é que usar 4 ou mais palavras aleatórias separadas por um "." (ponto)
        é mais seguro que uma senha como "Tr0ub4dor&3". Como por exemplo
        "correto.cavalo.bateria.grampo". Basta você lembrar de um cavalo dizendo que tem um grampo
        em uma bateria.
      </p>
      <p>Esse gerador contém {{ totalWords }} palavras</p>
    </div>

    <div class="password-input">
      <label for="senha_gerada">Senha:</label>
      <textarea id="senha_gerada" :value="passwordFormated" type="text" />
      <div class="options">
        <div class="option">
          <label for="palavras">Palavras:</label>
          <input id="palavras" v-model="wordNumber" min="4" type="number">
        </div>
        <div class="option">
          <label for="modificador">Modificador:</label>
          <input id="modificador" v-model="especialChar" type="text">
        </div>
      </div>
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
      generatedPassword: [
        'correto', 'cavalo', 'bateria', 'grampo'
      ],
      wordNumber: 4,
      especialChar: '.',
      wordList: []
    }
  },
  computed: {
    passwordFormated () {
      return this.generatedPassword.join(this.especialChar).toLowerCase()
    },
    totalWords () {
      return this.wordList.length || 'muitas'
    }
  },
  created () {
    if (!this.hasLocalStorage()) {
      this.createDb()
    } else {
      this.loadWordsFromStorage()
    }
  },
  methods: {
    getRandomWord () {
      const wordPosition = this.getRandomInt(this.wordList.length)
      return this.wordList[wordPosition]
    },
    genPassword () {
      const words = []
      for (let index = 0; index < this.wordNumber; index++) {
        words.push(this.getRandomWord())
      }
      this.generatedPassword = words
    },
    async createDb () {
      const words = await this.$axios.$get('/palavras/palavras.txt')
      this.wordList = words.split('\n')
      const wordListStore = JSON.stringify(words.split('\n'))
      window.localStorage.setItem('palavras', wordListStore)
    },
    getRandomInt (max) {
      return Math.floor(Math.random() * Math.floor(max))
    },
    hasLocalStorage () {
      const storage = window.localStorage
      const wordList = storage.getItem('palavras')
      return !!wordList
    },
    loadWordsFromStorage () {
      const storage = window.localStorage
      const wordList = storage.getItem('palavras')
      this.wordList = JSON.parse(wordList)
    }
  }
}
</script>

<style>
header {
  @apply py-4
}
.container {
  @apply min-h-screen flex flex-col justify-center mx-auto px-2;
}
h1 {
  @apply text-2xl mb-3
}
p {
  @apply mb-2
}
.password-input {
  @apply flex flex-col justify-center flex-grow-0
}
.options {
  @apply mb-4 flex flex-wrap
}
.option {
  @apply mb-2 w-1/2 flex flex-col
}
input,
textarea {
  @apply border py-1 px-2 rounded mx-2 flex items-center mb-2
}
button {
  @apply rounded-md py-2 px-6 border
}
</style>
