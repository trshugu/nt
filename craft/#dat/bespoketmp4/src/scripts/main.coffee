require('bespoke').from 'article', [
  require('bespoke-theme-cube')()
  require('bespoke-keys')()
  require('bespoke-touch')()
  require('bespoke-bullets')('li, .bullet')
  require('bespoke-backdrop')()
  require('bespoke-scale')()
  require('bespoke-hash')()
  require('bespoke-progress')()
  require('bespoke-forms')()
]

require('prism')
