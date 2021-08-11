var itemName = null;
var itemAmount = null;
var itemIdname = null;

$(document).ready(function () {
  setTheme();
  $(".container").hide();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
      openHome();
    }
    if (item.show == false) {
      close();
    }
    if (item.inventory) {
      // console.log(JSON.stringify(item.inventory, null, 2));
      $("#items").empty();
      item.inventory.forEach(element => {
        $("#items").append(`
          <div onclick="selectItem(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
            <p class="amount">${element.amount}</p>
            <p class="name">${element.name}</p>
          </div>
        `);
      });
    }
    if (item.notification == true) {
      Swal.fire(
        item.title,
        item.message,
        item.type
      )
    }
    if(item.weight && item.maxWeight) {
      $(".weight").html(item.weight + "/" + item.maxWeight + " kg");
      //$(".weight").html("200.00/200.00 KG");
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://kasperr_inventory/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://kasperr_inventory/close', JSON.stringify({}));
  });
});

function open() {
  $(".container").fadeIn();
  $("#home").css("display", "none");
  clearSelectedItem();
}
function close() {
  $(".container").fadeOut();
  $("#home").css("display", "none");
  clearSelectedItem();
}
function openHome() {
  $("#home").css("display", "block");
}

function selectItem(element) {
  itemName = element.dataset.name;
  itemAmount = element.dataset.amount;
  itemIdname = element.dataset.idname;
  $("#items div").css("background-color", "rgb(49, 145, 255)");
  $(element).css("background-color", "rgba(0, 255, 0, 0.705)");
}

function useItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Avertizare!',
      'Vă rugăm să introduceți un număr valid',
      'Avertizare!'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Avertizare!',
      'Numărul introdus este mai mare decât ceea ce aveți în inventar',
      'Avertizare!'
    )
  } else {
    if(itemIdname) {
      $.post('http://kasperr_inventory/useItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Avertizare!',
        'Vă rugăm să selectați un articol',
        'Avertizare!'
      )
    }
  }
}

function dropItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Avertizare!',
      'Vă rugăm să introduceți un număr valid',
      'Avertizare!'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Avertizare!',
      'Numărul introdus este mai mare decât ceea ce aveți în inventar',
      'Avertizare!'
    )
  } else {
    if(itemIdname !== null) {
      $.post('http://kasperr_inventory/dropItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Avertizare!',
        'Vă rugăm să selectați un articol',
        'Avertizare!'
      )
    }
  }
}

function giveItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Avertizare!',
      'Vă rugăm să introduceți un număr valid',
      'Avertizare!'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Avertizare!',
      'Numărul introdus este mai mare decât ceea ce aveți în inventar',
      'Avertizare!'
    )
  } else {
    if(itemIdname) {
      $.post('http://kasperr_inventory/giveItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Avertizare!',
        'Vă rugăm să selectați un articol',
        'Avertizare!'
      )
    }
  }
}

function setTheme() {
  if(configs.theme.primary_color && configs.theme.secondary_color) {
    let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
    let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
    $(":root").attr("style", primary_color + secondary_color);
  }
}

function clearSelectedItem() {
  itemName = null;
  itemAmount = null;
  itemIdname = null;
  $("#items div").css("background-color", "#ececec");
}