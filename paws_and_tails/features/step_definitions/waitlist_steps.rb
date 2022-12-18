When(/^(?:|I )click the button to join the waitlist$/) do
  expect(page).to have_css "#join-waitlist-btn"
  find("#join-waitlist-btn").click
end

When(/^(?:|I )click the button to leave the waitlist$/) do
  expect(page).to have_css "#leave-waitlist-btn"
  find("#leave-waitlist-btn").click
end
