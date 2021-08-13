
class HttpSupport {
    resultResJson (res, result, details) {
        res.json({
            result,
            details,
        })
    }
}

module.exports = new HttpSupport();