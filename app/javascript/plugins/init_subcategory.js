
const disableOthers = () => {
  document.querySelectorAll("#product_subcategory_id option").forEach(option => {
    option.hidden = true
  })
};

const initFilterSubcategory = () => {
const form = document.querySelector("#new_product")
if(form) {
    const category = document.querySelector("#product_category_id")
    category.addEventListener("change", (event) => {
    const currentlySelected = document.querySelector("#product_category_id option:checked")

    if (currentlySelected.innerText === "Beauty & Wellness") {
      disableOthers()
      document.querySelector("option[name='hair']").hidden = false
      document.querySelector("option[name='body']").hidden = false
      document.querySelector("option[name='hygene']").hidden = false
      //   ["Nutrition", "Care", "Baby Clothing"]
    } else if (currentlySelected.innerText === "Baby & Child") {
      disableOthers()
      document.querySelector("option[name='nutrition']").hidden = false
      document.querySelector("option[name='care']").hidden = false
      document.querySelector("option[name='baby clothing']").hidden = false
      // ["Vegatbles", "Fruits", "Meat"]
    } else if (currentlySelected.innerText === "Food & Beverages") {
      disableOthers()
      document.querySelector("option[name='vegatbles']").hidden = false
      document.querySelector("option[name='fruits']").hidden = false
      document.querySelector("option[name='meat']").hidden = false
      //   ["Plants", "Decoration", "Textiles"]
    } else if (currentlySelected.innerText === "Home & Decor") {
      disableOthers()
      document.querySelector("option[name='plants']").hidden = false
      document.querySelector("option[name='decoration']").hidden = false
      document.querySelector("option[name='textiles']").hidden = false
      //   ["Clothing", "Accessoires", "Shoes"]
    } else if (currentlySelected.innerText === "Fashion & Accessoires") {
      disableOthers()
      document.querySelector("option[name='clothing']").hidden = false
      document.querySelector("option[name='accessoires']").hidden = false
      document.querySelector("option[name='shoes']").hidden = false
      //   ["Sports wear", "Equipment", "Sneakers"]
    } else if (currentlySelected.innerText === "Sports") {
      disableOthers()
      document.querySelector("option[name='sports wear']").hidden = false
      document.querySelector("option[name='equipment']").hidden = false
      document.querySelector("option[name='sneakers']").hidden = false
    //   ["Media", "Smartphones", "Laptops"]
    } else {
      disableOthers()
      document.querySelector("option[name='media']").hidden = false
      document.querySelector("option[name='smartphones']").hidden = false
      document.querySelector("option[name='laptops']").hidden = false
    };
  });
};
};

export { initFilterSubcategory };
