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
      wordList: {
        a: {
          length: 0,
          words: []
        },
        b: {
          length: 0,
          words: []
        },
        c: {
          length: 0,
          words: []
        },
        d: {
          length: 0,
          words: []
        },
        e: {
          length: 0,
          words: []
        },
        f: {
          length: 0,
          words: []
        },
        g: {
          length: 0,
          words: []
        },
        h: {
          length: 0,
          words: []
        },
        i: {
          length: 0,
          words: []
        },
        j: {
          length: 0,
          words: []
        },
        k: {
          length: 0,
          words: []
        },
        l: {
          length: 0,
          words: []
        },
        m: {
          length: 0,
          words: []
        },
        n: {
          length: 0,
          words: []
        },
        o: {
          length: 0,
          words: []
        },
        p: {
          length: 0,
          words: []
        },
        q: {
          length: 0,
          words: []
        },
        r: {
          length: 0,
          words: []
        },
        s: {
          length: 0,
          words: []
        },
        t: {
          length: 0,
          words: []
        },
        u: {
          length: 0,
          words: []
        },
        v: {
          length: 0,
          words: []
        },
        w: {
          length: 0,
          words: []
        },
        x: {
          length: 0,
          words: []
        },
        y: {
          length: 0,
          words: []
        },
        z: {
          length: 0,
          words: []
        }
      }
    }
  },
  computed: {
    passwordFormated () {
      return this.generatedPassword.join(this.especialChar).toLowerCase()
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
      const allChars = Object.keys(this.wordList)
      const randomNumber = this.getRandomInt(allChars.length)
      const randomChar = allChars[randomNumber]
      const selectedWordList = this.wordList[randomChar]
      return selectedWordList.words[this.getRandomInt(selectedWordList.length)]
    },
    genPassword () {
      const words = []
      for (let index = 0; index < this.wordNumber; index++) {
        words.push(this.getRandomWord())
      }
      this.generatedPassword = words
    },
    async createDb () {
      await Promise.all(
        Object.keys(this.wordList).map(async (key) => {
          const words = await this.getWords(key)
          this.wordList[key].words = words
          this.wordList[key].length = words.length
          return key
        })
      )
      const wordListStore = JSON.stringify(this.wordList)
      window.localStorage.setItem('palavras', wordListStore)
    },
    async getWords (initial = 'q') {
      const palavras = await this.$axios.$get(`/palavras/${initial}_palavras.txt`)

      return palavras.split('\n')
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
  @apply mb-2 w-1/2
}
input,
textarea {
  @apply border py-1 px-2 rounded mx-2 flex items-center mb-2
}
button {
  @apply rounded-md py-2 px-6 border
}
</style>
