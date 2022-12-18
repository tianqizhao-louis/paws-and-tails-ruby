// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "controllers"


// ******** Not necessary - Just to make the navbar work ********
document.addEventListener('DOMContentLoaded', () => {
    // Get all "navbar-burger" elements
    const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

    // Add a click event on each of them
    $navbarBurgers.forEach( el => {
        el.addEventListener('click', () => {

            // Get the target from the "data-target" attribute
            const target = el.dataset.target;
            const $target = document.getElementById(target);

            // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
            el.classList.toggle('is-active');
            $target.classList.toggle('is-active');

        });
    });
});

document.addEventListener('DOMContentLoaded', () => {
    (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
        const $notification = $delete.parentNode;

        $delete.addEventListener('click', () => {
            $notification.parentNode.removeChild($notification);
        });
    });
});
// ******** Not necessary - Just to make the navbar work ********



// ******** Javascript Functions ********
document.addEventListener("DOMContentLoaded", function (event) {
    // ---------- Get the dropdown working ----------
    let dropdowns = document.querySelectorAll(".dropdown");
    dropdowns.forEach(item => {
        item.addEventListener("click", function (event) {
           event.stopPropagation();
           item.classList.toggle("is-active");
        });
    });

    let dropdownItemsCity = document.querySelectorAll(".city-dropdown-select");
    dropdownItemsCity.forEach(item => {
        item.addEventListener("click", function (event) {
           event.preventDefault();
           document.querySelector("#current-city").innerText = item.innerText;
        });
    });

    let dropdownItemsCountry = document.querySelectorAll(".country-dropdown-select");
    dropdownItemsCountry.forEach(item => {
       item.addEventListener("click", function (event) {
           event.preventDefault();
           document.querySelector("#current-country").innerText = item.innerText;
       });
    });
    // ---------- Dropdown ----------

    // ********** Submit Button **********
    let submitBtn = document.querySelector("#submit-location");
    submitBtn.addEventListener("click", function (event) {
       event.preventDefault();

        sendFetchToAnimals(document.querySelector("#current-city").innerText,
            document.querySelector("#current-country").innerText,
            "Any");
    });


    // ********** Reset Button **********
    let resetBtn = document.querySelector("#reset-location");
    resetBtn.addEventListener("click", function (event) {
        event.preventDefault();
        document.querySelector("#current-city").innerText = "Any City";
        document.querySelector("#current-country").innerText = "Any Country";

        sendFetchToAnimals("Any City", "Any Country", "Any");
    });


    // ********** Sorting Buttons **********
    let sortingBtnAll = document.querySelectorAll(".animal-sort-button");
    sortingBtnAll.forEach((item, index) => {
        item.addEventListener("click", function (event) {
           event.preventDefault();

           let sortingMethod = null;

           item.classList.forEach((cl_item, cl_index) => {
               if (/sort-.*/.test(cl_item)) {
                   sortingMethod = cl_item.split("-")[1];
               }
           });

           sendFetchToAnimals(document.querySelector("#current-city").innerText,
               document.querySelector("#current-country").innerText,
               sortingMethod);
        });
    });
});


/**
 * Send fetch request
 * @param city
 * @param country
 * @param sorting
 */
function sendFetchToAnimals(city, country, sorting) {
    // let token = getToken();
    fetch("/animals/api/sort_location", {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
            // 'X-Requested-With': 'XMLHttpRequest',
            // 'X-CSRF-Token': token
        },
        body: JSON.stringify({
            "city": city,
            "country": country,
            "sorting": sorting
        }),
        credentials: 'same-origin'
    })
        .then(response => response.json())
        .then(data => {
            emptyAnimalContainer();
            createAnimals(data["animals"], data["breeders"]);
        })
        .catch(error => {
            console.log(error);
        });
}

/**
 * Empty animal container column
 */
function emptyAnimalContainer() {
    document.querySelector("#animals-container").replaceChildren();
}

/**
 * Create animal grids
 * @param animals
 * @param breeders
 */
function createAnimals(animals, breeders) {
    if (animals.length === 0) {
        notFoundBanner();
    } else {
        let animalColumnSelector = document.querySelector("#animals-container");
        let elementCollections = "";
        animals.forEach((item, index) => {
            elementCollections += createEachAnimal(item, index, breeders);
        });
        animalColumnSelector.innerHTML = elementCollections;
    }
}


/**
 * Create each animal item in the grid
 * @param animal
 * @param index
 * @param breeders
 * @returns {string}
 */
function createEachAnimal(animal, index, breeders) {
    let element = "  <div class=\"column is-4\">\n" +
        "    <div class=\"card shadow-md is-cursor-pointer transform is-duration-300 hover-shadow-xl hover-translate-y\">\n" +
        "      <div class=\"card-image\">\n" +
        "        <figure class=\"image is-4by3\">";

    // image
    if (animal["image_link"] === null) {
        element += "<img src=\"https://bulma.io/images/placeholders/1280x960.png\" alt=\"Placeholder image\">";
    } else {
        element += "<img src='" + animal["image_link"] + "' alt='animal picture'>";
    }

    element += "        </figure>\n" +
        "      </div>\n" +
        "      <div class=\"card-content\">\n" +
        "        <div class=\"media\">\n" +
        "          <div class=\"media-content\"><p class=\"title is-4\">";

    element += "<a href='/animals/" + animal["id"] + "'>" + animal["name"] + "</a>";

    // breeder
    element += "</p>\n" +
        "            <p class=\"subtitle is-6\">@My breeder: ";

    element += breeders[index]["name"];
    element += "</p>\n" +
        "          </div>\n" +
        "        </div>\n" +
        "\n" +
        "        <div class=\"content\">\n" +
        "          Animal Type: ";

    element += animal["animal_type"];

    // breed
    element += "<br>\n" +
        "          Breed: "
    element += animal["breed"];

    // price
    element += "<br>\n" +
        "          Price: ";
    element += animal["price"];

    // birthday
    element += "<br>\n" +
        "          Anticipated Birth: ";
    element += new Date(animal["anticipated_birthday"]).toLocaleDateString("en-US").toString();

    // location
    element += "<br>\n" +
        "          <br>\n" +
        "          <strong>Location:</strong> ";
    element += breeders[index]["city"] + ", " + breeders[index]["country"]
    element += "</div>\n" +
        "      </div>\n" +
        "    </div>\n" +
        "  </div>"

    return element
}


/**
 * Not Found banner
 */
function notFoundBanner() {
    let bannerSelector = document.querySelector("#animals-container");
    bannerSelector.innerHTML = "<p>Sorry, not found. Please redo the search.</p>";
}


/**
 * For fetch call - get token
 * @returns {string}
 */
// function getToken() {
//     return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
// }