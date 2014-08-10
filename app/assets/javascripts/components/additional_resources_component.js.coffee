{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, form, p} = React.DOM

window.AdditionalResourcesComponent = React.createClass
  getTitleText: ->
    "Additional Resources"
  render: ->
    (div id: 'additional-resources-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h3 className: 'subheader', "Donate"),
      (p {}, "Consider Donating to X and Y")
      (p className: 'center', [
        (form action: "https://www.paypal.com/cgi-bin/webscr", method: "post", [
          (input type:"hidden", name:"cmd", value: "_donations"),
          (input type:"hidden", name:"business", value: "garidor@gmail.com"),
          (input type:"hidden", name:"lc", value: "US"),
          (input type:"hidden", name:"item_name", value: "Late Night Safety"),
          (input type:"hidden", name:"no_note", value: "0"),
          (input type:"hidden", name:"currency_code", value: "USD"),
          (input type:"hidden", name:"bn", value:"PP-DonationsBF:btn_donateCC_LG.gif:NonHostedGuest"),
          (input type:"image", src:"https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif", border:"0", name:"submit", alt:"PayPal - The safer, easier way to pay online!")
          ])
        ]),
      (h3 className: 'subheader', "Cab Numbers"),
      (ul {}, [
        (li {}, "Metro Cab 617-782-5500")
        (li {}, "Boston Cab Association 617-536-320")  
        (li {}, "ITOA Cab Associates 617-825-4000")  
        (li {}, "617TaxiCab 617-829-4222")          
        ])
      ])

    # <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
    # <input type="hidden" name="cmd" value="_donations">
    # <input type="hidden" name="business" value="garidor@gmail.com">
    # <input type="hidden" name="lc" value="US">
    # <input type="hidden" name="item_name" value="Late Night Safety">
    # <input type="hidden" name="no_note" value="0">
    # <input type="hidden" name="currency_code" value="USD">
    # <input type="hidden" name="bn" value="PP-DonationsBF:btn_donateCC_LG.gif:NonHostedGuest">
    # <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
    # <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
    # </form>
