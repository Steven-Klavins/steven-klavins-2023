# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "slim-select", to: "https://ga.jspm.io/npm:slim-select@2.5.0/dist/slimselect.es.js"
pin "stimulus-content-loader", to: "https://ga.jspm.io/npm:stimulus-content-loader@4.2.0/dist/stimulus-content-loader.mjs"
