const router = require('express').Router();
const commentController = require('../controllers/commentController');

router.post('/comment', commentController.create);
router.get('/comment', commentController.read);
router.delete('/comment/:id', commentController.remove);

module.exports = router;
