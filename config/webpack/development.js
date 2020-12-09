process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const webpack = require("webpack")

const config = environment.toWebpackConfig();

config.plugins.push(new webpack.NamedChunksPlugin((chunk) => {
    if (chunk.name) {
        return chunk.name;
    }
    return chunk.modules.map(m => path.relative(m.context, m.request)).join("_");
}));

module.exports = config
