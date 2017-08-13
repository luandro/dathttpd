const fs = require('fs');
const { EMAIl, DAT } = process.env;


const template = `
letsencrypt:
  email: '${EMAIL}'
  agreeTos: true
sites:
  dat.local:
    url: dat://${DAT}/
    datOnly: false
  datprotocol.dat.local:
    url: dat://ff34725120b2f3c5bd5028e4f61d14a45a22af48a7b12126d5d588becde88a93/
    datOnly: true
`;

console.log(`Building template for ${EMAIL}, ${DAT}.`);
fs.writeFileSync('~/.dathttpd.yml', template);
console.log('Writing file done!');