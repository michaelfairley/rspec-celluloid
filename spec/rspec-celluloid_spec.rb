describe "first" do
  it "is in an actor" do
    expect(Celluloid).to be_actor
    $actor_id = Celluloid::Actor.current.object_id
  end
end

describe "second" do
  it "is in a different actor" do
    expect(Celluloid).to be_actor
    sleep 0.1  until $actor_id
    expect(Celluloid::Actor.current.object_id).not_to eq $actor_id
  end
end
