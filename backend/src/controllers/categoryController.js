import Category from '../models/Category.js';

export const getCategories = async (req, res, next) => {
  try {
    const categories = await Category.findAllActive();
    res.json(categories);
  } catch (err) {
    next(err);
  }
};

export const getCategoryBySlug = async (req, res, next) => {
  try {
    const category = await Category.findBySlug(req.params.slug);
    if (!category) {
      return res.status(404).json({ message: 'Category not found.' });
    }
    res.json(category);
  } catch (err) {
    next(err);
  }
};
